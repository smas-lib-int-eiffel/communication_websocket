note
	description: "Summary description for {ENUMERATION_WEBSOCKET_MODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ENUMERATION_WEBSOCKET_MODE

create
	make

feature -- Creation

	make(a_mode: like mode)
		require
			correct_mode: is_type_valid (a_mode)
		do
			mode := a_mode
		ensure
			mode_set: mode = a_mode
		end

feature -- Types

	server: like mode = 1
			-- Web socket layer is used in server mode

	client: like mode = 2
			-- Web socket layer is used in client mode

feature -- Contract support

	is_type_valid (a_type: like mode): BOOLEAN
			-- If `a_type' valid?
		do
			inspect a_type
			when server, client then
				Result := True
			else
			end
		end

feature -- Query

	mode_type_as_string(a_type: like mode): STRING
			-- Result is a string representation of a_type.
		do
			create Result.make_empty
			inspect a_type
			when server then
				create Result.make_from_string("server")
			when client then
				create Result.make_from_string("client")
			end
		end

	is_mode_type_mappable( a_mode_type: STRING ): BOOLEAN
			-- Is state type mappable to a known websocket mode?
		do
			a_mode_type.to_lower
			if a_mode_type.is_equal ("server") then
				Result := True
			end
			if a_mode_type.is_equal ("client") then
				Result := True
			end
		end

	map_mode_type( a_mode_type: STRING ): like mode
			-- Map the mode type string, to a mode type
		require
			content_is_mappable: is_mode_type_mappable( a_mode_type )
		do
			a_mode_type.to_lower
			if a_mode_type.is_equal ("server") then
				Result := server
			end
			if a_mode_type.is_equal ("client") then
				Result := client
			end
		end

feature frozen -- Type information

	mode : INTEGER

invariant

	correct_mode: is_type_valid(mode)
			-- The type should always contain a valid value for representing the mode of the websocket communication layer
end

