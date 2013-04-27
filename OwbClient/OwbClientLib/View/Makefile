

#  View srcs
VIEW_SRCS_ = *.mm

#  libs
VIEW_OBJS = Canvas.o

export

.PHONY : all
all : $(VIEW_OBJS)

.PHONY : clean
clean :
	rm -rf $(VIEW_OBJS) 

$(VIEW_OBJS) : $(VIEW_SRCS_)
	$(CXX) $(CPPFLAGS) $(OBJFLAGS) $(CXXFLAGS) -c $(VIEW_SRCS_)
