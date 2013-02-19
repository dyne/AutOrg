/* munch header file */

#define MAX_LN_LEN    200
#define MAX_WD_LEN    200
#define MAX_PREFIXES  256
#define MAX_SUFFIXES  256
#define MAX_ROOTS      20
#define MAX_WORDS     5000
 
#define ROTATE_LEN      5
 
#define ROTATE(v,q) \
   (v) = ((v) << (q)) | (((v) >> (32 - q)) & ((1 << (q))-1));

#define SET_SIZE      256

#define XPRODUCT  (1 << 0)

/* the affix table entry */

struct affent
{
    char *  appnd;
    char *  strip;
    short   appndl;
    short   stripl;
    char    achar;
    char    xpflg;   
    short   numconds;
    char    conds[SET_SIZE];
};


struct affixptr
{
    struct affent * aep;
    int		    num;
};

/* the prefix and suffix table */
int	numpfx;		/* Number of prefixes in table */
int     numsfx;		/* Number of suffixes in table */

/* the prefix table */
struct affixptr          ptable[MAX_PREFIXES];

/* the suffix table */
struct affixptr          stable[MAX_SUFFIXES];


/* data structure to store results of lookups */
struct matches
{
    struct hentry *	hashent;	/* hash table entry */
    struct affent *	prefix;		/* Prefix used, or NULL */
    struct affent *	suffix;		/* Suffix used, or NULL */
};

int    numroots;	          /* number of root words found */
struct matches  roots[MAX_ROOTS]; /* list of root words found */

/* hashing stuff */

struct hentry
{
  char * word;
  char * affstr;
  struct hentry * next;
  int keep;
};

 
int             tablesize;
struct hentry * tableptr;

/* unmunch stuff */

int    numwords;	          /* number of words found */
struct dwords
{
  char * word;
  int pallow;
};

struct dwords  wlist[MAX_WORDS]; /* list words found */


/* the routines */

void parse_aff_file(FILE* afflst);

void encodeit(struct affent * ptr, char * cs);

int load_tables(FILE * wrdlst);

int hash(const char *);

int add_word(char *);

struct hentry * lookup(const char *);

void aff_chk (const char * word, int len);

void pfx_chk (const char * word, int len, struct affent* ep, int num);

void suf_chk (const char * word, int len, struct affent * ep, int num, 
	      struct affent * pfxent, int cpflag);

void add_affix_char(struct hentry * hent, char ac);

int expand_rootword(const char *, int, const char*, int);

void pfx_add (const char * word, int len, struct affent* ep, int num);

void suf_add (const char * word, int len, struct affent * ep, int num);

char * mystrsep(char ** stringp, const char delim);

char * mystrdup(const char * s);

void mychomp(char * s);
