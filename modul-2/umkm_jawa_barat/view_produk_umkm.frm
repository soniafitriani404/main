TYPE=VIEW
query=select `u`.`nama_usaha` AS `nama_usaha`,`pu`.`nama_produk` AS `nama_produk`,`pu`.`harga` AS `harga` from (`umkm_jawa_barat`.`produk_umkm` `pu` join `umkm_jawa_barat`.`umkm` `u` on(`pu`.`id_umkm` = `u`.`id_umkm`))
md5=097f740caf635a28526a99dfbfcb9dbc
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744962245783468
create-version=2
source=SELECT \n    u.nama_usaha,\n    pu.nama_produk,\n    pu.harga\nFROM produk_umkm pu\nJOIN umkm u ON pu.id_umkm = u.id_umkm
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `u`.`nama_usaha` AS `nama_usaha`,`pu`.`nama_produk` AS `nama_produk`,`pu`.`harga` AS `harga` from (`umkm_jawa_barat`.`produk_umkm` `pu` join `umkm_jawa_barat`.`umkm` `u` on(`pu`.`id_umkm` = `u`.`id_umkm`))
mariadb-version=100432
