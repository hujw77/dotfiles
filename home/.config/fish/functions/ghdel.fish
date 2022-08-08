function ghdel
  co
  for i in (git branch | grep echo);
	  git br -D (string trim $i)
  end
end
