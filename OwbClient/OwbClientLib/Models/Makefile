

#  Model srcs
MODEL_SRCS_ = *.mm

#  Libs
MODEL_OBJS = MessageModel.o BoardModel.o

export

.PHONY : all
all : $(MODEL_OBJS)

.PHONY : test
test : 
	$(MAKE) -C test

.PHONY : clean
clean :
	rm -rf $(MODEL_OBJS) 
	$(MAKE) clean -C test

$(MODEL_OBJS) : $(MODEL_SRCS_) 
	$(CXX) $(CPPFLAGS) $(OBJFLAGS) $(CXXFLAGS) -c $(MODEL_SRCS_)
