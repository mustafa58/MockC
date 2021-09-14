#ifndef __MOCK_H
#define __MOCK_H

#define RET(x) IS_PROBE( _NOT_ ## x )
#define IS_PROBE(...) SECOND(__VA_ARGS__, return)
#define SECOND(a, b, ...) b
#define _NOT_void PROBE()
#define PROBE() ~, 


/* macro to initialize mock before use */
#define mock_func_init(type, func, ...) \
static type (*func##__)(__VA_ARGS__) = NULL; \
type func(__VA_ARGS__) { RET(type) func##__(__VA_ARGS__); }

/* macro to set which mock func to use */
#define mock_set(func, mock) \
func##__ = mock

#endif //__MOCK_H