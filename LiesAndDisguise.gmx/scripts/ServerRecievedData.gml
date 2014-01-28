// get the buffer the data resides in
var buff = ds_map_find_value(async_load, "buffer");    
// read the first byte 
var cmd = buffer_read(buff, buffer_u8 );
// Get the socket ID - this is the CLIENT socket ID. We can use this as a "key" for this client
var sock = ds_map_find_value(async_load, "id");
// Look up the client details
var inst = ds_map_find_value(clients, sock);

//if its a lobby packet
if(cmd==CMD_LOBBY && global.gameState=cmd)
{
    //if the packet is of id lobby, and we are in the lobby stage, then this is relevant. 
    //read ready state
    ready[inst] = buffer_read(buff, buffer_bool);
    name[inst]= buffer_read(buff,buffer_string);
}

//if its a game packet and the gamestate matches
if(cmd==CMD_GAME && global.gameState=cmd){
    // read the second byte ( for the second command) 
    var secCmd = buffer_read(buff, buffer_u8 );
    //if its a keypres from the client
    if(secCmd ==CMD_KEYPRESS){
        //read the data and do whatevz with it
        //player number
        //var playerNo = buffer_read(buff, buffer_bool);
        //key pressed
        //with(instance_find(objPlayer,inst))event_user(buffer_read(buff,buffer_u8));
        var code = buffer_read(buff,buffer_u8);
        if(instance_find(objPlayer,inst).mHealth>0)
        {
            if(code<4)
                global.Keys[inst,code]=buffer_read(buff,buffer_bool);
            else
                with(instance_find(objPlayer,inst))event_user(code);
        }
        else
        {
            with(instance_find(objPlayer,inst))sprite_index=sprFatalBack;
        }
        //player health
        //with(instance_find(objPlayer,inst))mHealth = buffer_read(buff,buffer_u8);
             
    }

}
