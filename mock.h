#ifndef __MOCK_H
#define __MOCK_H

/* macro to initialize mock before use */
#define mock_func_init(type, func, ...) \
static type (*func##__)(__VA_ARGS__) = NULL; \
type func(__VA_ARGS__) { func##__(); }

/* macro to set which mock func to use */
#define mock_set(func, mock) \
func##__ = mock

#endif //__MOCK_H