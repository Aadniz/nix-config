{ config, lib, pkgs, username, ... }:

{
  users.users.${username}.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDNteqCXydLzQpOG0jejpAJG14PIdgrNMwfTqd+P9hOGoPFodJgnJ84a0uaa1MWK0RSb6go99Do15WwqMiB1qPBWHy6ecpPspGgY4H6qneMDfX2ng2++vM/oW/B3OGoRMf3DcF3qWH4XovAYMbDUueyYL7KxvHw1/cgtLtvjJdXhFS3pG6bwka3dH3YDcAFZ841vsXBlarsG2wYXXcaMc5ca+kz1I9l9XoLwcL2pMbck/Hx0j2CGAgKaTpiJ8MPyy+slnG/aHcGF9z6jWRehotoMxgFWeZEN1YjEr17/iZGxTP+l8LQS+iQeXL02X5n3pu+AMshBBOO3cjgQprMNbMzaAn8vn91gPhKjQ8wlxLY8VIen9HHHc/G3WtLUlGK0izkvSi0xu6sXnYSaoIE9ucKNzVNgaZUiLbxxVph5c1YLtvo/7LcXwc8lRY42LNTyNMQ46gUMFFsC4aQzC6/DngWyQNtvplzv4FRPbwfSAvMgXZ3L2KXg+5k7ekERC1u9pc= chiya@arch"
  ];
}
