version (Windows) extern (Windows)
{
	import std.stdio; 
	
	import core.sys.windows.windows;
	import core.sys.windows.winbase; // CreateFileA // From fileapi.h
	import core.sys.windows.winnt; 
	
	void main(string[] args) { 
	
	
	/+
	
	In the ANSI version of this function, the name is limited to MAX_PATH characters. To extend this limit to 32,767 wide characters, call the 
	Unicode version of the function and prepend "\\?\" to the path. For more information, see Naming Files, Paths, and Namespaces.
	https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea
	+/
	
	
	HANDLE fileHandle = CreateFileA(
		"filename.txt",               // lpFileName
		GENERIC_READ | GENERIC_WRITE, // dwDesiredAccess
		0,                            // dwShareMode
		null,                         // lpSecurityAttributes
		CREATE_NEW,                   // dwCreationDisposition
		FILE_ATTRIBUTE_NORMAL,        // dwFlagsAndAttributes
		null                          // hTemplateFile
	);
	
	if (fileHandle == INVALID_HANDLE_VALUE) {
		// https://docs.microsoft.com/en-us/windows/win32/api/fileapi/nf-fileapi-createfilea#return-value
		writeln("Failed to create a file.");
		

		// https://docs.microsoft.com/en-us/windows/win32/debug/system-error-codes--0-499-
		// ERROR_FILE_EXISTS 80 (0x50)


		DWORD dw = GetLastError(); 
		writeln(dw);
			
		
			}

	
	// dwShareMode: 0 - Prevents other processes from opening a file or device if they request delete, read, or write access.
	
    /* lpSecurityAttributes: If this parameter is NULL, the handle returned by CreateFile cannot be inherited by any child processes the 
    application may create and the file or device associated with the returned handle gets a default security descriptor. */ 
	
	// hTemplateFile: The template file supplies file attributes and extended attributes for the file that is being created.
									  
	   writeln(); 
	   writeln("test"); 
	}
}