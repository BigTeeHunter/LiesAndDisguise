/// Networking code
var eventid = ds_map_find_value(async_load, "id");
// Our socket?
if( client == eventid )
{
    // Read all data....
    var buffer = ds_map_find_value(async_load, "buffer");
    
    //read the first  8 bits to see what type of packet it is
    var cmd = buffer_read(buffer, buffer_u8 ); 
    
    //if its a packet that contains lobby data
    if(cmd==global.gameState && cmd==CMD_LOBBY){
        // Get number of players
        global.playerTotal = buffer_read(buffer, buffer_u8 ); 
        global.MyNumber = buffer_read(buffer,buffer_u8);
        for(var i=0;i<global.playerTotal;i++){
            ready[i]=buffer_read(buffer,buffer_bool);
            name[i]=buffer_read(buffer,buffer_string);
        }  
    }
    
    //if its a packet tellingn us its a game packet
    if(cmd==CMD_GAME){
        //check what type of game packet it is
        var sunCmd = buffer_read(buffer, buffer_u8 ); 
        
        //if its a start game packet
        if(sunCmd == CMD_GAME_START){
            //set the game state to playing
            global.gameState = CMD_GAME;
            
            //read the No of players there is
            global.playerTotal = buffer_read(buffer, buffer_u8 );
            
            //take note of your ID number
            global.MyNumber = buffer_read(buffer,buffer_u8);
            //show_message(global.MyNumber);
            global.seed = buffer_read(buffer, buffer_u32);
            global.traitor = buffer_read(buffer, buffer_bool);
            
            //show_message(global.traitor);
            
            room_goto(rmGame);
        }
        
        //if its a game packet and its fill of data and the game is currently playing
        if(sunCmd == CMD_GAME_DATA && global.gameState = CMD_GAME){
            
            //unpack the data
            //player count
             //read the No of players there is
            global.playerTotal = buffer_read(buffer, buffer_u8 );
            //this players inst ID
            global.MyNumber = buffer_read(buffer,buffer_u8);
            var count=0
            for(var i=0; i<global.playerTotal; i++){
                var tId;
                if(i=global.MyNumber)
                {
                    tId=objPlayer;
                }
                else
                {
                    tId=instance_find(objOtherPlayer,count);
                    count++;
                }
                with(tId)
                {
                    x = buffer_read(buffer, buffer_u16);
                    y = buffer_read(buffer, buffer_u16);
                    sprite_index = buffer_read(buffer, buffer_u8);
                    image_xscale = buffer_read(buffer, buffer_f32);
                    image_blend = buffer_read(buffer, buffer_u32);
                    var tHealth = buffer_read(buffer, buffer_u8);
                    if(tHealth!=mHealth)
                    {//health has changed, play scream and blood
                        mHealth=tHealth;
                        spurtBlood(x,y);
                        play_sound(choose(sndScream1,sndScream2,sndScream3), 10, false);
                    }
                    mCurrentWeapon = buffer_read(buffer, buffer_u8);
                }
            }
        }
        //if its a game packet and its about traps
        if(sunCmd == CMD_TRAP_ACTIVATION && global.gameState = CMD_GAME){
            //unpack the data
            with(buffer_read(buffer,buffer_u32))event_user(10);
        }
        //if game is over
        if(sunCmd == CMD_GAME_END && global.gameState = CMD_GAME){
            //unpack the data
            var b= buffer_read(buffer,buffer_bool);
            global.gameState=CMD_LOBBY;
            if(b)
                room_goto(TraitorWin);
            else
                room_goto(TraitorLose);
        }
    }
}
