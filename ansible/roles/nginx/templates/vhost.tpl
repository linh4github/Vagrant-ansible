server {
  listen 80;
  server_name {{ item.servername }};

  root {{ item.docroot }};

  index  {{ item.index }};

  access_log            /var/log/nginx/{{ item.servername }}.access.log combined;
  error_log             /var/log/nginx/{{ item.servername }}.error.log;

  location ~ /\. {
    access_log off;
    log_not_found off;
    deny all;
  }

  location ~ \.php$ {
    root  {{ item.docroot }};
    index {{ item.index }};
    fastcgi_index {{ item.index }};
    fastcgi_param PATH_INFO $fastcgi_path_info;
    fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_pass  unix:{{ php_socket }};
    fastcgi_split_path_info ^(.+\.php)(/.+)$;
    include fastcgi_params;
    server_tokens off;
  }
  
  try_files $uri $uri/ /{{ item.index }}?$args;
}
