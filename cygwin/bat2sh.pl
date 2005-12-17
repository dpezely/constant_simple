#! /bin/perl -w

print STDERR "bat2sh.pl - converting XSI's setenv.bat file to Borne shell syntax\n";

# The file to be converted might be:
# C:/Softimage/XSI_*/Application/bin/Setenv.bat 
# ~/Softimage/XSI_*/Addons/workgroup_shader_plugins.bat

foreach (<>) {
  s|^@.cho off|#! /bin/sh |;

  if (m|^(.*)([A-Z]):(.*)$|g) {	# drive letters
      $a = $1;
      $b = $2;
      $c = $3;
      $b =~ tr|A-Z|a-z|;
      $_ = "$a/cygdrive/$b$c";
  }

  s|\\|/|g;			# path delimiters

  s|%([^%]+)%|\$$1|g;		# variable identification

  if (m|^(set )*Path=(.*)$|i) {	# path definition
      $path = $2;
      $path =~ s|path|PATH|ig;
      $path =~ s|\;|:|g;
      $_ = "export PATH=\"$path\"";
  }

  s|^rem |# |;

  s|^set (.*)=$|unset $1|;
  s|set ([^=]+)="(.*)"$|export $1="$2"|;
  s|set ([^=]+)='(.*)'$|export $1="$2"|;
  s|set ([^=]+)=(.*)$|export $1="$2"|;

  s|if exist (\S+) (.*)$|if [ -f $1 ]; then\n  $2\nfi|;

  s|call |. |;
  s|\.bat|.sh|;

  s|||;
  chomp;

  print "$_\n";
}
