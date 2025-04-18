TYPE=VIEW
query=select `p`.`nik` AS `nik`,`p`.`nama_lengkap` AS `nama_lengkap`,`p`.`jenis_kelamin` AS `jenis_kelamin`,`p`.`nomor_telepon` AS `nomor_telepon`,`p`.`email` AS `email`,`u`.`nama_usaha` AS `nama_usaha` from (`umkm_jawa_barat`.`pemilik_umkm` `p` join `umkm_jawa_barat`.`umkm` `u` on(`p`.`id_pemilik` = `u`.`id_pemilik`))
md5=9e27fd050b5375918f81c2d8371170b4
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744958290137304
create-version=2
source=SELECT \n    p.nik,\n    p.nama_lengkap,\n    p.jenis_kelamin,\n    p.nomor_telepon,\n    p.email,\n    u.nama_usaha\nFROM pemilik_umkm p\nJOIN umkm u ON p.id_pemilik = u.id_pemilik
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `p`.`nik` AS `nik`,`p`.`nama_lengkap` AS `nama_lengkap`,`p`.`jenis_kelamin` AS `jenis_kelamin`,`p`.`nomor_telepon` AS `nomor_telepon`,`p`.`email` AS `email`,`u`.`nama_usaha` AS `nama_usaha` from (`umkm_jawa_barat`.`pemilik_umkm` `p` join `umkm_jawa_barat`.`umkm` `u` on(`p`.`id_pemilik` = `u`.`id_pemilik`))
mariadb-version=100432
