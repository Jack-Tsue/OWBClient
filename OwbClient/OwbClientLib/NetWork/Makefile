

#  Net srcs
NET_SRCS_ = *.cc $(RCF_DIR)/src/RCF/RCF.cpp

#  libs
NET_OBJS = RCF.o ServerDelegate.o

export

.PHONY : all
all : $(NET_OBJS)

.PHONY : test
test : 
	$(MAKE) -C test

.PHONY : clean
clean :
	rm -rf $(NET_OBJS) 
	$(MAKE) clean -C test

$(NET_OBJS) : $(NET_SRCS_)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $(NET_SRCS_)
