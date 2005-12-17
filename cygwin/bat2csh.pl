#! /bin/perl -w

print STDERR "bat2csh.pl - converting XSI's setenv.bat file to csh syntax\n";

# The file to be converted might be:
# C:/Softimage/XSI_*/Application/bin/Setenv.bat 
# ~/Softimage/XSI_*/Addons/workgroup_shader_plugins.bat

foreach (<>) {
  s|^@.cho off|#! /bin/csh |;

  if (m|^(.*)([A-Z]):(.*)$|g) {	# drive letters
      $a = $1;
      $b = $2;
      $c = $3;
      $b =~ tr|A-Z|a-z|;
      $_ = "$a/cygdrive/$b$c";
  }

  s|\\|/|g;			# path delimiters

  s|%([^%]+)%|\$$1|g;		# variable identification

  if (m|^(set )*Path=(.*)$|i) {
      $path = $2;
      $path =~ s|path|PATH|ig;
      $path =~ s|\;|:|g;
      $_ = "setenv PATH \"$path\"";
  }

  s|^rem |# |;

  s|^set (.*)=$|unsetenv $1|;
  s|set ([^=]+)="(.*)"$|setenv $1 "$2"|;
  s|set ([^=]+)='(.*)'$|setenv $1 "$2"|;
  s|set ([^=]+)=(.*)$|setenv $1 "$2"|;

  s|if exist (\S+) (.*)$|if `[ -f $1 ]` then\n  $2\nendif|;

  s|call |source |;
  s|\.bat|.csh|;

  s|||;
  chomp;

  print "$_\n";
}
