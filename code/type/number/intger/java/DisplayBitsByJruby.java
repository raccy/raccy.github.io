import org.jruby.Ruby;
class DisplayBitsByJruby
{
	public static void main (String[] args) throws java.lang.Exception
	{
		Ruby.newInstance().evalScriptlet("printf('%08b', gets.to_i);puts");
	}
}
