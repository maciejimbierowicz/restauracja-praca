# Init build templates
```bash
git submodule add git@bitbucket.org:droptica/scm-build-system.git build/ansible
```
Optional:    

```bash
git submodule add [url_repo] app 
```    
**Delete the 'Init build templates' section after initiating the project.**


# Checkout sources

```bash
git clone git@bitbucket.org:droptica/domain.tld.git .
cd domain.tld
./exec.sh init
```
# Dev: Assets
```bash
./exec.sh download-db
```
# Dev: Build
```bash
./exec.sh pull
./exec.sh up -d
./exec.sh ansible build
```