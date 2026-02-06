when a node is sending, the other node should wait until it is done, and send

however, the problem is that multiple nodes will be in a queue up then collide if multiple nodes send

solved with [[Binary Exponential Backoff (BEB)]]
