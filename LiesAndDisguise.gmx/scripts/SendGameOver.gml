buffer_seek(buff, buffer_seek_start,0);
buffer_write(buff, buffer_u8, CMD_GAME );
buffer_write(buff, buffer_u8, CMD_GAME_END);
buffer_write(buff, buffer_bool, argument0);
var buffer_size = buffer_tell(buff);
for(var i=0;i<count;i++){
    var sock = ds_list_find_value(socketlist,i);
    network_send_packet(sock, buff, buffer_size );
}
return 0;
