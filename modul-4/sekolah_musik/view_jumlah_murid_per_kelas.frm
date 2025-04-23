TYPE=VIEW
query=select `k`.`nama_kelas` AS `nama_kelas`,count(`p`.`id_murid`) AS `jumlah_murid` from (`sekolah_musik`.`kelasmusik` `k` join `sekolah_musik`.`pendaftaran` `p` on(`k`.`id_kelas` = `p`.`id_kelas`)) group by `k`.`nama_kelas`
md5=8da1aeb5957d453572754bf21db9732c
updatable=0
algorithm=0
definer_user=root
definer_host=localhost
suid=2
with_check_option=0
timestamp=0001744963695948881
create-version=2
source=SELECT \n    k.nama_kelas,\n    COUNT(p.id_murid) AS jumlah_murid\nFROM KelasMusik k\nJOIN Pendaftaran p ON k.id_kelas = p.id_kelas\nGROUP BY k.nama_kelas
client_cs_name=utf8
connection_cl_name=utf8_general_ci
view_body_utf8=select `k`.`nama_kelas` AS `nama_kelas`,count(`p`.`id_murid`) AS `jumlah_murid` from (`sekolah_musik`.`kelasmusik` `k` join `sekolah_musik`.`pendaftaran` `p` on(`k`.`id_kelas` = `p`.`id_kelas`)) group by `k`.`nama_kelas`
mariadb-version=100432
