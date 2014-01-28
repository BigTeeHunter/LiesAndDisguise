//
// arg 0 = the key to be sent
// arg 1 = up (true) down (false)

// Move to start of buffer. Networking ALWAYS takes the data from the START of a buffer.
buffer_seek(global.ntwk.buff, buffer_seek_start, 0);

buffer_write(global.ntwk.buff, buffer_u8, CMD_GAME );
buffer_write(global.ntwk.buff, buffer_u8, CMD_KEYPRESS );
//var b = false;
//if(global.MyNumber!=-1)instNO=global.MyNumber;
//var tempID = instance_find(objPlayer,global.MyNumber);
//buffer_write(global.ntwk.buff, buffer_u16, instNO ); 
buffer_write(global.ntwk.buff,buffer_u8, argument0);
buffer_write(global.ntwk.buff,buffer_bool,argument1);
//buffer_write(global.ntwk.buff,buffer_u8,tempID.mHealth);

//should send positional data for check

// Send this to the server
network_send_packet( global.ntwk.client, global.ntwk.buff, buffer_tell(global.ntwk.buff) );

//it goes
//pack ID
//pack type
// clients inst number
//the key
//clients health?
