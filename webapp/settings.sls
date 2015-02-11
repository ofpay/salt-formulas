{% set p = salt['pillar.get']('webapp', {}) %}
{% set g = salt['grains.get']('webapp', {}) %}

{% set webappConst = {} %}
{%- do webappConst.update({'repoBase'   : 'nexus.dev.ofpay.com/nexus/service/local/artifact/maven/redirect?',
                           'fileType'   : 'war',
                           'nfsDir'     : '',
                           'serverDir'  : '',
                           'unzip'      : false,
                           'dubboAdminIp'    : '172.19.65.13',
                           'dubboAdminPort'  : '8080',
                           'dubboRootPasswd' : 'master123'
                           }) %}


{% set webapp = {} %}
{%- do webapp.update({'projectName': 'cardbase',
                      'nfsServer'  : '192.168.111.210',
                      'groupId'    : 'com.ofpay',
                      'artifactId' : 'cardserverimpl',
                      'version'    : '1.6.2-RELEASE',
                      'repoBase'   : 'nexus.dev.ofpay.com/nexus/service/local/artifact/maven/redirect?',
                      'fileType'   : 'war',
                      'logHome'    : '/oflogs',
                      'volHome'    : '/vol',
                      'nfsDir'     : '',
                      'serverDir'  : '',
                      'unzip'      : false,
                      'dubboAdminIp'    : '172.19.65.13',
                      'dubboAdminPort'  : '8080',
                      'dubboRootPasswd' : 'master123',
                      'md5'             : '1234567890'
                      }) %}

{% for key, value in webapp.iteritems() %}
{% do webapp.update({key: p.get(key, g.get(key, value))}) %}
{% endfor %}

{% set fileUrl  = p.get('fileUrl', webapp.repoBase + 'r=public&g=' + webapp.groupId + '&a=' + webapp.artifactId + '&v=' + webapp.version + '&e=' + webapp.fileType) %}
{% set fileSha1 = p.get('fileSha1', fileUrl + '.sha1') %}

{%- do webapp.update({'fileUrl'    : fileUrl,
                      'fileSha1'   : fileSha1
                      }) %}
