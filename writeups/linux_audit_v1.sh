 
#!/bin/bash

 uptime

echo -e "\e[32mKernel:\e[0m $(uname -r)"

echo -e "\e[32mUser:\e[0m $(whoami)"

echo -e "\e[32mopen ports:\e[0m $(ss -tuln)"

echo -e "\e[32mRecent System Logs:"
	journalctl -n 10 --no-pager

echo -e "\e[32mRecent Failed Logins:"
	journalctl _SYSTEMD_UNIT=sshd.service -p warning --no-pager 
