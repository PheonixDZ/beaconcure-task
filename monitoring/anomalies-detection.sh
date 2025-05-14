#!/bin/bash

# === CONFIGURATION ===
NAMESPACE="image-processing-app"
LABEL_SELECTOR="app.kubernetes.io/name=image-processing"
PATTERN="4[0-9]{2}|5[0-9]{2}|ERROR|Exception|Failure"  # Customize this pattern
SLACK_WEBHOOK_URL="REPACE"
SLEEP_INTERVAL=10  # seconds

# === VALIDATION ===

fatal_error() {
    echo "❌ ERROR: $1"
    exit 1
}

# Check kubectl
command -v kubectl >/dev/null 2>&1 || fatal_error "kubectl is not installed or not in PATH."

# Check AWS CLI
command -v aws >/dev/null 2>&1 || fatal_error "AWS CLI is not installed or not in PATH."

# Check if AWS credentials are available (env or config file)
if ! aws sts get-caller-identity --output text >/dev/null 2>&1; then
    if [ -z "$AWS_ACCESS_KEY_ID" ] && [ ! -f "$HOME/.aws/credentials" ]; then
        fatal_error "AWS credentials not found. Please set environment variables or configure ~/.aws/credentials."
    else
        fatal_error "AWS credentials are set but invalid or expired. Run 'aws configure' or re-authenticate."
    fi
fi

# Check Kubernetes cluster connectivity
if ! kubectl cluster-info >/dev/null 2>&1; then
    fatal_error "Unable to connect to the Kubernetes cluster. Check your kubeconfig and EKS authentication. Run aws eks update-kubeconfig --name <cluster-name> --region <region>"
fi

# Check namespace
if ! kubectl get namespace "$NAMESPACE" >/dev/null 2>&1; then
    fatal_error "Namespace '$NAMESPACE' not found or access denied."
fi


# === FUNCTION TO SEND SLACK NOTIFICATION ===
send_notification() {
    local pod="$1"
    local log_snippet="$2"

    # Escape quotes and backslashes, then replace newlines with \n
    log_snippet=$(printf "%s" "$log_snippet" | sed 's/\\/\\\\/g; s/"/\\"/g; s/$/\\n/')

    curl -s -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"🚨 *Anomaly detected in pod \`$pod\`*:\n\`\`\`\n$log_snippet\n\`\`\`\"}" \
        "$SLACK_WEBHOOK_URL"
}

# === INITIALIZE TIMESTAMP ===
LAST_CHECK_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

echo "🔍 Monitoring logs in namespace '$NAMESPACE' for pods with label '$LABEL_SELECTOR'..."

while true; do
    CURRENT_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

    PODS=$(kubectl get pods -n "$NAMESPACE" -l "$LABEL_SELECTOR" -o jsonpath="{range .items[*]}{.metadata.name}{'\n'}{end}")

    if [ -z "$PODS" ]; then
        echo "❌ No pods found matching the label in namespace '$NAMESPACE'."
        sleep "$SLEEP_INTERVAL"
        exit 1
    fi

    for POD in $PODS; do
        echo "📄 Checking logs for pod: $POD since $LAST_CHECK_TIME"
        LOGS=$(kubectl logs "$POD" -n "$NAMESPACE" --since-time="$LAST_CHECK_TIME" 2>/dev/null)

        if echo "$LOGS" | grep -E "$PATTERN" > /dev/null; then
            MATCHES=$(echo "$LOGS" | grep -E "$PATTERN" | tail -n 10)
            echo "⚠️ Anomaly found in pod: $POD"
            send_notification "$POD" "$MATCHES"
        else
            echo "✅ No new anomalies in pod: $POD"
        fi
    done

    LAST_CHECK_TIME="$CURRENT_TIME"
    echo "⏳ Sleeping for $SLEEP_INTERVAL seconds..."
    sleep "$SLEEP_INTERVAL"
done
