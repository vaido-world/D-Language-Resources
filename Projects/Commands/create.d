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
		
		extern(C) size_t sizeof();

		LPVOID lpMsgBuf;
		LPVOID lpDisplayBuf;
		DWORD dw = GetLastError(); 
		   FormatMessage(
				FORMAT_MESSAGE_ALLOCATE_BUFFER | 
				FORMAT_MESSAGE_FROM_SYSTEM |
				FORMAT_MESSAGE_IGNORE_INSERTS,
				NULL,
				dw,
				MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT),
				cast(LPTSTR) &lpMsgBuf,
				0, 
				NULL 
			);
				
				import core.stdc.stdio;
				import core.stdc.stdlib;
				lpDisplayBuf = cast(LPVOID)LocalAlloc(LMEM_ZEROINIT, 
					(lstrlen(cast(LPCTSTR)lpMsgBuf)  + 40) * char.sizeof); //What is the Size of TCHAR? 
				StringCchPrintf(cast(LPTSTR)lpDisplayBuf,  // Unsure in which header the function is // strsafe.h
					LocalSize(lpDisplayBuf) / sizeof(TCHAR), 
					TEXT(" failed with error %d: %s"), // Same for the TEXT // Pointer to the string to interpret as UTF-16 or ANSI. // winnt.h TEXT macro // https://docs.microsoft.com/en-us/windows/win32/api/winnt/nf-winnt-text
					 dw, lpMsgBuf); 
				MessageBox(NULL, cast(LPCTSTR)lpDisplayBuf, TEXT("Error"), MB_OK); 
			
				LocalFree(lpMsgBuf);
				LocalFree(lpDisplayBuf);
				ExitProcess(dw); 
			}

	
	// dwShareMode: 0 - Prevents other processes from opening a file or device if they request delete, read, or write access.
	
    /* lpSecurityAttributes: If this parameter is NULL, the handle returned by CreateFile cannot be inherited by any child processes the 
    application may create and the file or device associated with the returned handle gets a default security descriptor. */ 
	
	// hTemplateFile: The template file supplies file attributes and extended attributes for the file that is being created.
									  
	   writeln(); 
	   writeln("test"); 
	}
}