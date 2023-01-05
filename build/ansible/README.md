# scm-build-system
Attach scm-build-system to project:
 - git submodule add git@bitbucket.org:droptica/scm-build-system.git build/ansible


Custom dirs and custom files
--------------
For custom dirs you have to add in build.yml after import_role: build-files so many times how many you need use it.

When you need change yours app path from declared env "app_path=/app/app" to upper directory, for example "/app" you need define dst_dir_custom with two dots "dst_dir_custom: ../dst_dir_custom". You can also create empty dir without files.

Example:
```ansible
- import_role:
    name: build-files-custom
  vars:
    src_file_custom: "/files/sites/site.com.pl/build-files-custom.tar.gz"
    dst_dir_custom: "public/media"
  tags: files-custom
  when: D_ENV != "prod"
```