typedef char* string;

// Path: standard/basic/string/string.c

//itoa implementation
string reverse(string str, int length)
{
	int start = 0;
	int end = length - 1;
	while (start < end)
	{
		char temp = *(str + start);
		*(str + start) = *(str + end);
		*(str + end) = temp;
		start++;
		end--;
	}
	return str;
}
int strlen(string str)
{
	int len = 0;
	while (*(str + len) != '\0')
	{
		len++;
	}
	return len;
}