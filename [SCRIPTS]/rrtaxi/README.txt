RRtaxi is a mod which lets you do taxi missions. Instead of driving players, as with most taxi resources, you are driving bots. That makes this script especially usefull for servers that don't have too many players online at the same time, or lan-servers. Now you don't have to wait for ages as a taxi driver until finaly somebody needs your services, there's always work for you to do.

INSTALLATION: copy rrtaxi.zip to your resources directory and add the following line to your mtaserver.conf: <resource src="rrtaxi" startup="1" protected="0"/>

INGAME: Players with a bus- or limo driver skin can do taxi missions, this because it makes it easy to implement in any server for quick testing and it can be easily changed. 

PLAYER COMMANDS:
/startjob - starts the taxi mission
/quitjob - aborts the taxi mission
NOTE: if you don't have the right skin, it will output that you don't have a job.

ADMIN COMMANDS:
/addPickup - adds your current location as a taxi pickup and dropoff location

Currently, the city of Las Venturas is pretty much covered with pickup points, but the other cities are not. Those need to be manually added using the /addPickup command.

This is my first ever lua script, so please bear with me.

TODO:
The current taxi rewards only depend on distance, I might make it depend on time and driving skills(by calculating damage the vehicle took during the ride) as well. I make no promises on that though, since im also working on other scripts.