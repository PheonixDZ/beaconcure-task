#!/bin/bash

# Base URL
BASE_URL="http://localhost:3000"

echo "Testing Metrics Implementation..."
echo "================================"

# 1. Test Health Check
echo -e "\n1. Testing Health Check"
curl -s "${BASE_URL}/api/status"

# 2. Test Metrics Endpoint
echo -e "\n\n2. Checking Metrics Endpoint"
curl -s "${BASE_URL}/metrics"

# 3. Test Error Cases
echo -e "\n\n3. Testing Error Cases"
# Test invalid image upload (non-PNG file)
echo -e "\nTesting invalid image upload:"
curl -s -X POST -F "images=@package.json" "${BASE_URL}/api/images"

# Test invalid image retrieval
echo -e "\nTesting invalid image retrieval:"
curl -s "${BASE_URL}/api/images?id=nonexistent"

# 4. Test Successful Image Upload
echo -e "\n\n4. Testing Successful Image Upload"
# Create a test PNG file
echo "Creating test PNG file..."
convert -size 100x100 xc:white test.png

# Upload the test image
echo -e "\nUploading test image:"
curl -s -X POST -F "images=@test.png" "${BASE_URL}/api/images"

# 5. Check Metrics Again
echo -e "\n\n5. Final Metrics Check"
curl -s "${BASE_URL}/metrics"

# Cleanup
rm -f test.png

echo -e "\n\nTest Complete!" 
