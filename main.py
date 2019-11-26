import os
import requests
import urllib.parse
import json
import subprocess

def main():
    label = 'build'
    message = 'fail'
    color = 'red'
    badge_prefix = 'tmp'
    if 'PLUGIN_BADGE_PREFIX' in os.environ:        
        badge_prefix = os.environ.get('PLUGIN_BADGE_PREFIX')
    if 'PLUGIN_JSON_FILE' in os.environ:
        # always save json file in /drone/src (drone workspace)
        with open('/drone/src/' + os.environ.get('PLUGIN_JSON_FILE')) as json_file:
            data = json.load(json_file)
            label = data['label']
            message = data['message']
            color = data['color']
    else:
        message = os.environ.get('DRONE_BUILD_STATUS')
        if message == 'success':
            color = 'brightgreen'

    label = urllib.parse.quote(label, safe='')
    message = urllib.parse.quote(message, safe='')
    available_color = ['brightgreen', 'green', 'yellowgreen', 'yellow', 'orange', 'red', 'blue', 'lightgrey']
    if color not in available_color:
        color = 'blue'
    shields_io_url = 'https://raster.shields.io/badge/' + label + '-' + message + '-' + color
    r = requests.get(url = shields_io_url, allow_redirects=True)
    if not os.path.exists('/drone/src/images/badges'):
        os.mkdir('/drone/src/images/badges')
    open('/drone/src/images/badges' + badge_prefix + '_badge.png', 'wb').write(r.content)
    subprocess.call(['./upload_to_aws.sh'])

main()
