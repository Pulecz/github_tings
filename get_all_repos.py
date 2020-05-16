#!/bin/python
import requests
import sys

try:
    username=sys.argv[1]
except IndexError:
    print('No username provided')
    sys.exit(1)

url = f'https://api.github.com/users/{username}/repos'  

repos=requests.get(url)

ssh_urls = []
for repo in repos.json():
    print(repo.get('ssh_url'))
    ssh_urls.append(repo.get('ssh_url'))
