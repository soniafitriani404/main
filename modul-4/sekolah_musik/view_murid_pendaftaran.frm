TYPE=VIEW
query=select `m`.`id_murid` AS `id_murid`,`m`.`nama` AS `nama_murid`,`p`.`tanggal_pendaftaran` AS `tanggal_pendaftaran` from (`sekolah_musik`.`murid` `m` join `sekolah_musik`.`pendaftaran` `p` on(`m`.`id_murid` = `p`.`id_murid`))
md5=9d22d585f900597f0c1c1b7312a7dbdc
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744864612581323
create-version=2
source=SELECT \n    m.id_murid,\n    m.nama AS nama_murid,\n    p.tanggal_pendaftaran\nFROM Murid m\nJOIN Pendaftaran p ON m.id_murid = p.id_murid
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `m`.`id_murid` AS `id_murid`,`m`.`nama` AS `nama_murid`,`p`.`tanggal_pendaftaran` AS `tanggal_pendaftaran` from (`sekolah_musik`.`murid` `m` join `sekolah_musik`.`pendaftaran` `p` on(`m`.`id_murid` = `p`.`id_murid`))
mariadb-version=100432
