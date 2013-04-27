

#  Tool srcs
TOOLS_SRCS_ = *.mm

#  libs
TOOLS_OBJS = ColorMaker.o Drawer.o OperationQueue.o

export

.PHONY : all
all : $(TOOLS_OBJS)

.PHONY : test
test : 
	$(MAKE) -C test

.PHONY : clean
clean :
	rm -rf $(TOOLS_OBJS) 
	$(MAKE) clean -C test

$(TOOLS_OBJS) : $(TOOLS_SRCS_)
	$(CXX) $(CPPFLAGS) $(OBJFLAGS) $(CXXFLAGS) -c $(TOOLS_SRCS_)
