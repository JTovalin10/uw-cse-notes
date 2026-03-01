# Global Internet
## Routing areas
Our goal is to partition a routing domain into subdomains called areas. This extra level of hierarchy thus allows single domains to grow larger without overburdening the routing protocls or resorting to the more complex interdomain routing protocols
**Area: a set of routers that are adminstrively configured to exchange link-state information with each other**

### Areas
Area 0: the backbone area this is teh area which all other areas are connected to. However this doenst mean that they only connect to this area
![[Pasted image 20260228225922.png]]
As shown in the image, R1 is a member of both area 1 and 2. A router that is a member of both the backbone area and non-backbone area is called an area border router (ABR).

Withint a single area, we use routing protocols found in [[CSE461/Routing Layer/Routing|Routing]]. The main differnce here si that all the routers in the area send link-state adveritsments to each other and thus develop a complete, consistent map of the area. However, if they are not area border routers then the link-state advertisments do not leave the area they orginated from. THis makes flooding and route calculation a lot more scalable. Going back to the image, R4 in area 3 will never see an link-state advertisement from area 1. the question then **how does a ruter in one area determine the right next hop for a packet destgined tro a network in antoerh area**

Imagine the pathof a packet that has to travel from one non-backbone area to antoehr as being split into three parts
1. it travels from its source network to the backbone area
2. it crosses the backbone
3. it travels from the backbone to the destination network
In order to achieve this the area border routers summarize routing information that they have learned from one area and make it avalaible in their avertisements to other areas
### Virtual Link
to more flexibly decide which routers go in area one we use *virtual links*. A virtual link is obtained by configuring a router that is not directly connected to area 0 to exchange backbone routing information

## Interdomain Routing (BGP)
The internet is organized as *autonomous systems (AS)*, the basic idea behind the, is to provvide an additional way to hierarchially aggregate routing information in a large internet which imporves scvalability. Additionally, it decouples the intradomain rouyting tha ttakes place in one ASW freom that taking place in another hence we can run whatever intradomain rouyting protocol it wants.
1. routing with a single AS (interdomain routing)
2. routing between AS's (intradomain routing)
AS is also known as routing domains so we can call this interdomain and intradomain routing
## Intradomain Routing
### Goals
optimizing the scalar cost of the path
// AI link my other notes here
### Interdomain Routing 
#### Goals
1. find some path to the intended destination that is loop free
2. paths msut be compliant with policies of the various AS along the path
Finding a non-looping polocu compliant pathj
#### Challenges
The problem with this is having differnt Ases share reachability information - descripitons of the set of IP addresses that can be reaches via a given AS - with each other.

The most important challenge is that erach AS needs to determine its own routing policies. THe issue then becomes economiuc arragements.

We need to be able to implement a policy without any help from other automoous systems and in the face of possible misconfiguration or maliciuus behvaior from other AS. ADditionally [[Internet Service Provider (ISP)]] want to keep their polcieis private because they dont want to make their economic arrangements public due to competition

2. a backbone mus tbe able to forward any packet desitned anywhere in teh internet which means having a routing table that will provide a match for any valid IP address
3. we do not pick the optimal path as AS might not want to take it due to cost
### Interdomain Protocols
#### Exterior Gateway Protocol (EGP)
this is an old protocol which was designed when the internet had a tree-like design which means that it constraint the topology of the internet.
#### Border Gateway Protocl (BGP)
This makes no assumptions about hwo the AS are interconnecterd and form an arbitary graph. 

local traffic: traffic that orginates at or terminates on nodes within an AS
transit traffic: traffic that passes through an AS
#### Autonomous Systems types
1. Sub
	1. an AS that only carries local traffic
2. multihomed stub
	1. an AS that has connections to more than one other AS but that refuses to carry transit traffic
3. Transit
	1. an AS that has connections to more than one other AS and that is designed to carry both transit and local traffic
Border Router: an IP router that is charged with the task of forwarding packets bnetween AS
BGP Speaker: a router that speaks BGP to other BGP speakers in other AS.
BGP does not belong to [[Distance-Vector Routing]] nor [[Link State Routing]], it advertises complete paths as an enumerated list of AS to each a particular network 
![[Pasted image 20260228233817.png]]
. Assume that the providers are transit networks, while the customer networks are stubs. A BGP speaker for the AS of provider A (AS 2) would be able to advertise reachability information for each of the network numbers assigned to customers P and Q. Thus, it would say, in effect, “The networks 128.96, 192.4.153, 192.4.32, and 192.4.3 can be reached directly from AS 2.” The backbone network, on receiving this advertisement, can advertise, “The networks 128.96, 192.4.153, 192.4.32, and 192.4.3 can be reached along the path (AS 1, AS 2).” Similarly, it could advertise, “The networks 192.12.69, 192.4.54, and 192.4.23 can be reached along the path (AS 1, AS 3).”

A speakr when given multiple choices will choose the best one accordding to its own local polciies and then that will be the route it advertises. Its important to note that an BGP speaker does not need to advertise any route to a destination even if it has one. 

Upon link failures oir plicies changes, speakers need to be able to cancel previously advertises paths which is done with a form of negative advertisement known as a withdrawn route. Both positive and negative reachability information are carried in a BGP udpate messagfe with teh format:
![[Pasted image 20260228234457.png]]
### Packet format
To prevent loops the BGP must carry an AS number that is unique so that it can recognizxe itself (it is 32-bits long) and assined by cnetral authority to assure uniqueness
### TCP
BGP is defined to run on top of TCP as speakers can count on TCP to be relaible. THis means that any information that has been sent from one speaker to antoehr does nto need to be sent again. Thus, if nothing has changed then a speaker can siomply send an occsiaonly keepalive message so they will know when a router dies

## Common AS relationship and policies
![[Pasted image 20260228234704.png]]
- provider-customer
	- roviders are in the business of connecting their customers to the rest of the Internet. A customer might be a corporation, or it might be a smaller ISP (which may have customers of its own). So the common policy is to advertise all the routes I know about to my customer, and advertise routes I learn from my customer to everyone.
- customer-provider
	- In the other direction, the customer wants to get traffic directed to him (and his customers, if he has them) by his provider, and he wants to be able to send traffic to the rest of the Internet through his provider. So the common policy in this case is to advertise my own prefixes and routes learned from my customers to my provider, advertise routes learned from my provider to my customers, but don’t advertise routes learned from one provider to another provider. That last part is to make sure the customer doesn’t find himself in the business of carrying traffic from one provider to another, which isn’t in his interests if he is paying the providers to carry traffic for him.
- peer
	- The third option is a symmetrical peering between autonomous systems. Two providers who view themselves as equals usually peer so that they can get access to each other’s customers without having to pay another provider. The typical policy here is to advertise routes learned from my customers to my peer, advertise routes learned from my peer to my customers, but don’t advertise routes from my peer to any provider or _vice versa_.

## Integrating Interdomain and Intradomain Routing
Let’s start with a very simple situation, which is also very common. In the case of a stub AS that only connects to other autonomous systems at a single point, the border router is clearly the only choice for all routes that are outside the AS. Such a router can inject a _default route_ into the intradomain routing protocol. In effect, this is a statement that any network that has not been explicitly advertised in the intradomain protocol is reachable through the border router. Recall from the discussion of IP forwarding in the previous chapter that the default entry in the forwarding table comes after all the more specific entries, and it matches anything that failed to match a specific entry.

The next step up in complexity is to have the border routers inject specific routes they have learned from outside the AS. Consider, for example, the border router of a provider AS that connects to a customer AS. That router could learn that the network prefix 192.4.54/24 is located inside the customer AS, either through BGP or because the information is configured into the border router. It could inject a route to that prefix into the routing protocol running inside the provider AS. This would be an advertisement of the sort, “I have a link to 192.4.54/24 of cost X.” This would cause other routers in the provider AS to learn that this border router is the place to send packets destined for that prefix.

The final level of complexity comes in backbone networks, which learn so much routing information from BGP that it becomes too costly to inject it into the intradomain protocol. For example, if a border router wants to inject 10,000 prefixes that it learned about from another AS, it will have to send very big link-state packets to the other routers in that AS, and their shortest-path calculations are going to become very complex. For this reason, the routers in a backbone network use a variant of BGP called _interior BGP_ (iBGP) to effectively redistribute the information that is learned by the BGP speakers at the edges of the AS to all the other routers in the AS. (The other variant of BGP, discussed above, runs between autonomous systems and is called _exterior BGP_, or eBGP). iBGP enables any router in the AS to learn the best border router to use when sending a packet to any address. At the same time, each router in the AS keeps track of how to get to each border router using a conventional intradomain protocol with no injected information. By combining these two sets of information, each router in the AS is able to determine the appropriate next hop for all prefixes.
![[Pasted image 20260228235108.png]]![[Pasted image 20260228235137.png]]