note
	description: "Summary description for {LAYER_SESSION_WEBSOCKET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LAYER_SESSION_WEBSOCKET

inherit
	LAYER_SESSION
		redefine
			transmit
		end


	WEB_SOCKET_EVENT_I

create make

feature -- Creation

	make(a_mode: like mode; a_websocket: WEB_SOCKET)
		do
			mode := a_mode
			websocket := a_websocket
		end

feature {LAYER} -- Communication

	transmit( a_data_unit: READABLE_STRING_8 )
			-- Transmit data unit to receiver
		do
			websocket.send (Text_frame, a_data_unit)
		end

feature {LAYER} -- Session features

	connect(an_address_information: ADDRESS_INFORMATION)
			-- Create a session for the current communication layer, is only available for clients.
		do
			check is_client_mode: mode = {ENUMERATION_WEBSOCKET_MODE}.client end
		end

	disconnect
			-- Terminate the current session
		do
			-- To be implemented!!!
		end

feature -- Mode

	mode: ENUMERATION_WEBSOCKET_MODE
			-- The communication layer websocket mode

feature -- Websocket execution

	on_open (ws: WEB_SOCKET)
		do
			connected
		end

	on_binary (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		do
			receive (a_message)
		end

	on_text (ws: WEB_SOCKET; a_message: READABLE_STRING_8)
		do
			receive (a_message)
		end

	on_close (ws: WEB_SOCKET)
			-- Called after the WebSocket connection is closed.
		do
			disconnected
		end

feature {NONE} -- The EWF Web Socket

	websocket: WEB_SOCKET
		 -- The Eiffel Web Framework Web Socket

end
