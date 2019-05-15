EXE_ANAGRAM = anagram_finder
EXE = lab_dict
EXE_FAC = fac
EXE_HOMOPHONE = homophone_puzzle
EXE_COMMON_WORDS = find_common_words

OBJS_DIR = .objs
OBJS_ANAGRAM_STUDENT = anagram_dict.o
OBJS_ANAGRAM_PROVIDED = anagram_finder.o
OBJS_FIB_STUDENT = fib.o
OBJS_FIB_PROVIDED = main.o
OBJS_FAC_STUDENT =
OBJS_FAC_PROVIDED = fac.o
OBJS_HOMOPHONE_STUDENT = pronounce_dict.o cartalk_puzzle.o
OBJS_HOMOPHONE_PROVIDED = homophone_puzzle.o
OBJS_COMMON_WORDS_STUDENT = common_words.o
OBJS_COMMON_WORDS_PROVIDED = find_common_words.o

CXX = clang++
LD = clang++
WARNINGS = -pedantic -Wall -Werror -Wfatal-errors -Wextra -Wno-unused-parameter -Wno-unused-variable
CXXFLAGS = -std=c++1y -stdlib=libc++ -g -O0 $(WARNINGS) -MMD -MP -c
LDFLAGS = -std=c++1y -stdlib=libc++ -lc++abi -lpthread

all: $(EXE) \
	$(EXE_FAC)

data:
	svn export https://subversion.ews.illinois.edu/svn/sp17-cs225/_shared/lab_dict_data data

# Pattern rules for object files
$(OBJS_DIR)/%.o: %.cpp | $(OBJS_DIR)
	$(CXX) $(CXXFLAGS) $< -o $@

# Create directories
$(OBJS_DIR):
	@mkdir -p $(OBJS_DIR)

# Rules for executables... we can use a pattern for the -asan versions, but, unfortunately, we can't use a pattern for the normal executables
$(EXE):
	$(LD) $^ $(LDFLAGS) -o $@
$(EXE_FAC):
	$(LD) $^ $(LDFLAGS) -o $@

# Executable dependencies
$(EXE):               $(patsubst %.o, $(OBJS_DIR)/%.o,        $(OBJS_COMMON_WORDS_STUDENT)) \
							$(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_ANAGRAM_STUDENT)) \
							$(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_HOMOPHONE_STUDENT))  \
							$(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_FIB_STUDENT)) \
							$(patsubst %.o, $(OBJS_DIR)/%.o, $(OBJS_FIB_PROVIDED))
$(EXE_FAC):               $(patsubst %.o, $(OBJS_DIR)/%.o,      $(OBJS_FAC_STUDENT)) $(patsubst %.o, $(OBJS_DIR)/%.o, $(OBJS_FAC_PROVIDED))

# Include automatically generated dependencies
-include $(OBJS_DIR)/*.d

clean:
	rm -rf $(EXE_ANAGRAM) \
		$(EXE) \
		$(EXE_FAC) \
		$(EXE_HOMOPHONE) \
		$(EXE_COMMON_WORDS) \
		$(OBJS_DIR)

tidy: clean
	rm -rf doc

.PHONY: all tidy clean
