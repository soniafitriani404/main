TYPE=VIEW
query=select `m`.`nama` AS `nama_murid`,`k`.`nama_kelas` AS `nama_kelas`,`k`.`biaya` AS `biaya` from ((`sekolah_musik`.`murid` `m` join `sekolah_musik`.`pendaftaran` `p` on(`m`.`id_murid` = `p`.`id_murid`)) join `sekolah_musik`.`kelasmusik` `k` on(`p`.`id_kelas` = `k`.`id_kelas`)) where `k`.`biaya` > 200000
md5=d25d4ce62641e79d03eb9d874b8fb860
updatable=1
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744963691052315
create-version=2
source=SELECT \n    m.nama AS nama_murid,\n    k.nama_kelas,\n    k.biaya\nFROM Murid m\nJOIN Pendaftaran p ON m.id_murid = p.id_murid\nJOIN KelasMusik k ON p.id_kelas = k.id_kelas\nWHERE k.biaya > 200000
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `m`.`nama` AS `nama_murid`,`k`.`nama_kelas` AS `nama_kelas`,`k`.`biaya` AS `biaya` from ((`sekolah_musik`.`murid` `m` join `sekolah_musik`.`pendaftaran` `p` on(`m`.`id_murid` = `p`.`id_murid`)) join `sekolah_musik`.`kelasmusik` `k` on(`p`.`id_kelas` = `k`.`id_kelas`)) where `k`.`biaya` > 200000
mariadb-version=100432
