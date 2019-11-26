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

### Details 📒

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
