SESSION_FILE := ovpn-session.txt

.PHONY: vpn
vpn:
	sudo openvpn --client --config drama.ovpn

.PHONY: conn
conn:
	sudo openvpn3 session-start --config drama.ovpn --dco true | tee /dev/tty | \
		grep -o 'Session path: /net/openvpn/v3/sessions/[^ ]*' | \
		sed 's/Session path: //' > $(SESSION_FILE)

.PHONY: status
status:
	sudo openvpn3 sessions-list

.PHONY: disconn
disconn:
	SESSION_PATH=$$(cat $(SESSION_FILE) | tr -d '[:space:]'); \
		sudo openvpn3 session-manage --path "$$SESSION_PATH" --disconnect;