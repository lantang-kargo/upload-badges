# Drone Upload Badge Plugin

## Quickstart 🚀

```yaml
kind: pipeline
name: default

steps:
  
  - name: upload badges
    image: lstama/upload-badge:latest
    settings:
      s3_bucket:
        from_secret: s3_bucket
      badge_prefix: driver_android_test
      json_file: properties.json
```

Save properties.json in /drone/src/properties.json

### Details 📒

Parameter:

1. s3_bucket The S3 Bucket of the image

2. badge_prefix The prefix of image filename, default is 'tmp'

3. json_file The filename of properties of the image.

4. aws_assume_role_arn (Optional) If you want to use assume role to different account, default is login as drone.

JSON file format:

```json
{
  "label" : "label",
  "message" : "message",
  "color" : "brightgreen"
}
```
Available color : ['brightgreen', 'green', 'yellowgreen', 'yellow', 'orange', 'red', 'blue', 'lightgrey']

Image will be saved in <s3_bucket>/badges/<badge_prefix>_badge.png
