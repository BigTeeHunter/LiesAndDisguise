// Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
buffer_seek(buff, buffer_seek_start, 0);

buffer_write(buff, buffer_u8, CMD_LOBBY );
var b = false;
if(global.MyNumber!=-1)b=ready[global.MyNumber];
buffer_write(buff, buffer_bool, b ); 
buffer_write(buff, buffer_string, global.playerName);

// Send this to the server
network_send_packet( client, buff, buffer_tell(buff) );
