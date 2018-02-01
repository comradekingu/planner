#include <gio/gio.h>

#if defined (__ELF__) && ( __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 6))
# define SECTION __attribute__ ((section (".gresource.as"), aligned (8)))
#else
# define SECTION
#endif

static const SECTION union { const guint8 data[800]; const double alignment; void * const ptr;}  as_resource_data = { {
  0x47, 0x56, 0x61, 0x72, 0x69, 0x61, 0x6e, 0x74, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x18, 0x00, 0x00, 0x00, 0xc8, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x28, 0x06, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x03, 0x00, 0x00, 0x00, 
  0x03, 0x00, 0x00, 0x00, 0x04, 0x00, 0x00, 0x00, 
  0x05, 0x00, 0x00, 0x00, 0x06, 0x00, 0x00, 0x00, 
  0x94, 0x5d, 0xdc, 0x97, 0x05, 0x00, 0x00, 0x00, 
  0xc8, 0x00, 0x00, 0x00, 0x07, 0x00, 0x4c, 0x00, 
  0xd0, 0x00, 0x00, 0x00, 0xd4, 0x00, 0x00, 0x00, 
  0xba, 0x5b, 0xdf, 0x52, 0x00, 0x00, 0x00, 0x00, 
  0xd4, 0x00, 0x00, 0x00, 0x09, 0x00, 0x4c, 0x00, 
  0xe0, 0x00, 0x00, 0x00, 0xe4, 0x00, 0x00, 0x00, 
  0x04, 0x3a, 0x15, 0x25, 0x04, 0x00, 0x00, 0x00, 
  0xe4, 0x00, 0x00, 0x00, 0x0f, 0x00, 0x76, 0x00, 
  0xf8, 0x00, 0x00, 0x00, 0x07, 0x03, 0x00, 0x00, 
  0xd4, 0xb5, 0x02, 0x00, 0xff, 0xff, 0xff, 0xff, 
  0x07, 0x03, 0x00, 0x00, 0x01, 0x00, 0x4c, 0x00, 
  0x08, 0x03, 0x00, 0x00, 0x0c, 0x03, 0x00, 0x00, 
  0x39, 0x34, 0x1c, 0x61, 0x01, 0x00, 0x00, 0x00, 
  0x0c, 0x03, 0x00, 0x00, 0x08, 0x00, 0x4c, 0x00, 
  0x14, 0x03, 0x00, 0x00, 0x18, 0x03, 0x00, 0x00, 
  0xc2, 0xaf, 0x89, 0x0b, 0x03, 0x00, 0x00, 0x00, 
  0x18, 0x03, 0x00, 0x00, 0x04, 0x00, 0x4c, 0x00, 
  0x1c, 0x03, 0x00, 0x00, 0x20, 0x03, 0x00, 0x00, 
  0x67, 0x69, 0x74, 0x68, 0x75, 0x62, 0x2f, 0x00, 
  0x01, 0x00, 0x00, 0x00, 0x61, 0x6c, 0x61, 0x69, 
  0x6e, 0x6d, 0x32, 0x33, 0x2f, 0x00, 0x00, 0x00, 
  0x04, 0x00, 0x00, 0x00, 0x61, 0x70, 0x70, 0x6c, 
  0x69, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x2e, 
  0x63, 0x73, 0x73, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0xf0, 0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 
  0x78, 0xda, 0x7d, 0x90, 0xc1, 0x6e, 0x84, 0x20, 
  0x14, 0x45, 0xf7, 0x7e, 0xc5, 0x4b, 0xdc, 0xb4, 
  0x93, 0xe2, 0xa0, 0x8d, 0x5d, 0xe0, 0xae, 0x49, 
  0xf7, 0xfd, 0x05, 0x90, 0xa7, 0x92, 0x61, 0x80, 
  0x20, 0x56, 0x4d, 0x33, 0xff, 0x5e, 0xd4, 0x99, 
  0xc9, 0xd8, 0xc5, 0x40, 0x42, 0x42, 0xb8, 0xf7, 
  0xbc, 0xcb, 0x3d, 0x1e, 0x24, 0x36, 0xca, 0x20, 
  0xa9, 0xad, 0xb6, 0x1e, 0xd6, 0xf3, 0xdb, 0xab, 
  0x33, 0xf7, 0x33, 0xa4, 0x54, 0x96, 0x85, 0x68, 
  0xaa, 0xc3, 0x31, 0xc9, 0x82, 0x0a, 0x1a, 0x05, 
  0xf7, 0xf0, 0x9b, 0x40, 0x5c, 0x8e, 0x4b, 0xa9, 
  0x4c, 0xcb, 0x80, 0xc2, 0x87, 0x9b, 0xaa, 0xe4, 
  0xf2, 0xa0, 0xc8, 0xb4, 0x32, 0x27, 0x94, 0x90, 
  0x89, 0x21, 0x04, 0x6b, 0xae, 0x0e, 0x61, 0xbd, 
  0x44, 0x4f, 0x3c, 0x97, 0x6a, 0xe8, 0xa3, 0xaf, 
  0xda, 0x73, 0xf2, 0xc2, 0x4d, 0x90, 0xd3, 0x85, 
  0xf5, 0xa0, 0x0e, 0xd6, 0x91, 0x51, 0xc9, 0xd0, 
  0xdd, 0x0d, 0xc2, 0x4e, 0xa4, 0xef, 0xb8, 0xb4, 
  0x23, 0x03, 0x63, 0x0d, 0x3e, 0x1d, 0xcd, 0xea, 
  0x0e, 0xeb, 0xe5, 0xbe, 0x45, 0xd8, 0x99, 0x95, 
  0xe9, 0x31, 0xc4, 0xf8, 0xcb, 0xce, 0xe3, 0x6c, 
  0xae, 0x5d, 0xc7, 0xe1, 0x25, 0xa5, 0x94, 0xbe, 
  0x01, 0xcd, 0x68, 0xf9, 0x1a, 0x07, 0x46, 0x76, 
  0xc3, 0x7f, 0xac, 0x57, 0x01, 0x89, 0x8b, 0xe8, 
  0x2b, 0x68, 0x6d, 0x89, 0x41, 0xfa, 0xf5, 0x5e, 
  0x94, 0x25, 0x5d, 0x23, 0xdc, 0x65, 0xad, 0xc7, 
  0xf9, 0x9f, 0xec, 0x93, 0x2e, 0x7b, 0x4b, 0x3a, 
  0x22, 0x06, 0x82, 0x26, 0xf8, 0x9b, 0x48, 0xf0, 
  0xfa, 0xd4, 0x7a, 0x3b, 0x18, 0xc9, 0x60, 0xec, 
  0x22, 0x61, 0x57, 0x40, 0x1f, 0x66, 0x8d, 0x0c, 
  0x7a, 0xab, 0x95, 0xdc, 0x3d, 0xdc, 0x5a, 0xc9, 
  0x8a, 0x72, 0xeb, 0x1f, 0xb2, 0xd5, 0x4d, 0xe2, 
  0x1f, 0x9f, 0x90, 0x2f, 0x7f, 0xf5, 0x09, 0x98, 
  0x48, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 
  0x00, 0x28, 0x75, 0x75, 0x61, 0x79, 0x29, 0x2f, 
  0x05, 0x00, 0x00, 0x00, 0x70, 0x6c, 0x61, 0x6e, 
  0x6e, 0x65, 0x72, 0x2f, 0x02, 0x00, 0x00, 0x00, 
  0x63, 0x6f, 0x6d, 0x2f, 0x00, 0x00, 0x00, 0x00
} };

static GStaticResource static_resource = { as_resource_data.data, sizeof (as_resource_data.data), NULL, NULL, NULL };
G_GNUC_INTERNAL GResource *as_get_resource (void);
GResource *as_get_resource (void)
{
  return g_static_resource_get_resource (&static_resource);
}
/*
  If G_HAS_CONSTRUCTORS is true then the compiler support *both* constructors and
  destructors, in a sane way, including e.g. on library unload. If not you're on
  your own.

  Some compilers need #pragma to handle this, which does not work with macros,
  so the way you need to use this is (for constructors):

  #ifdef G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA
  #pragma G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(my_constructor)
  #endif
  G_DEFINE_CONSTRUCTOR(my_constructor)
  static void my_constructor(void) {
   ...
  }

*/

#ifndef __GTK_DOC_IGNORE__

#if  __GNUC__ > 2 || (__GNUC__ == 2 && __GNUC_MINOR__ >= 7)

#define G_HAS_CONSTRUCTORS 1

#define G_DEFINE_CONSTRUCTOR(_func) static void __attribute__((constructor)) _func (void);
#define G_DEFINE_DESTRUCTOR(_func) static void __attribute__((destructor)) _func (void);

#elif defined (_MSC_VER) && (_MSC_VER >= 1500)
/* Visual studio 2008 and later has _Pragma */

#define G_HAS_CONSTRUCTORS 1

/* We do some weird things to avoid the constructors being optimized
 * away on VS2015 if WholeProgramOptimization is enabled. First we
 * make a reference to the array from the wrapper to make sure its
 * references. Then we use a pragma to make sure the wrapper function
 * symbol is always included at the link stage. Also, the symbols
 * need to be extern (but not dllexport), even though they are not
 * really used from another object file.
 */

/* We need to account for differences between the mangling of symbols
 * for Win32 (x86) and x64 programs, as symbols on Win32 are prefixed
 * with an underscore but symbols on x64 are not.
 */
#ifdef _WIN64
#define G_MSVC_SYMBOL_PREFIX ""
#else
#define G_MSVC_SYMBOL_PREFIX "_"
#endif

#define G_DEFINE_CONSTRUCTOR(_func) G_MSVC_CTOR (_func, G_MSVC_SYMBOL_PREFIX)
#define G_DEFINE_DESTRUCTOR(_func) G_MSVC_DTOR (_func, G_MSVC_SYMBOL_PREFIX)

#define G_MSVC_CTOR(_func,_sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void);              \
  int _func ## _wrapper(void) { _func(); g_slist_find (NULL,  _array ## _func); return 0; } \
  __pragma(comment(linker,"/include:" _sym_prefix # _func "_wrapper")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _wrapper;

#define G_MSVC_DTOR(_func,_sym_prefix) \
  static void _func(void); \
  extern int (* _array ## _func)(void);              \
  int _func ## _constructor(void) { atexit (_func); g_slist_find (NULL,  _array ## _func); return 0; } \
   __pragma(comment(linker,"/include:" _sym_prefix # _func "_constructor")) \
  __pragma(section(".CRT$XCU",read)) \
  __declspec(allocate(".CRT$XCU")) int (* _array ## _func)(void) = _func ## _constructor;

#elif defined (_MSC_VER)

#define G_HAS_CONSTRUCTORS 1

/* Pre Visual studio 2008 must use #pragma section */
#define G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA 1
#define G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA 1

#define G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(_func) \
  section(".CRT$XCU",read)
#define G_DEFINE_CONSTRUCTOR(_func) \
  static void _func(void); \
  static int _func ## _wrapper(void) { _func(); return 0; } \
  __declspec(allocate(".CRT$XCU")) static int (*p)(void) = _func ## _wrapper;

#define G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(_func) \
  section(".CRT$XCU",read)
#define G_DEFINE_DESTRUCTOR(_func) \
  static void _func(void); \
  static int _func ## _constructor(void) { atexit (_func); return 0; } \
  __declspec(allocate(".CRT$XCU")) static int (* _array ## _func)(void) = _func ## _constructor;

#elif defined(__SUNPRO_C)

/* This is not tested, but i believe it should work, based on:
 * http://opensource.apple.com/source/OpenSSL098/OpenSSL098-35/src/fips/fips_premain.c
 */

#define G_HAS_CONSTRUCTORS 1

#define G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA 1
#define G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA 1

#define G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(_func) \
  init(_func)
#define G_DEFINE_CONSTRUCTOR(_func) \
  static void _func(void);

#define G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(_func) \
  fini(_func)
#define G_DEFINE_DESTRUCTOR(_func) \
  static void _func(void);

#else

/* constructors not supported for this compiler */

#endif

#endif /* __GTK_DOC_IGNORE__ */

#ifdef G_HAS_CONSTRUCTORS

#ifdef G_DEFINE_CONSTRUCTOR_NEEDS_PRAGMA
#pragma G_DEFINE_CONSTRUCTOR_PRAGMA_ARGS(resource_constructor)
#endif
G_DEFINE_CONSTRUCTOR(resource_constructor)
#ifdef G_DEFINE_DESTRUCTOR_NEEDS_PRAGMA
#pragma G_DEFINE_DESTRUCTOR_PRAGMA_ARGS(resource_destructor)
#endif
G_DEFINE_DESTRUCTOR(resource_destructor)

#else
#warning "Constructor not supported on this compiler, linking in resources will not work"
#endif

static void resource_constructor (void)
{
  g_static_resource_init (&static_resource);
}

static void resource_destructor (void)
{
  g_static_resource_fini (&static_resource);
}
