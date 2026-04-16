import request from '../utils/request'; // 引入上面封装的实例

/**
 * 用户登录
 * @param {Object} data - 登录表单数据 { username: '...', password: '...' }
 */
export function login(data) {
    return request({
        url: '/user/login',
        method: 'post',
        data,
    });
}

/**
 * 用户注册
 * @param {Object} data - 注册表单数据
 */
export function register(data) {
    return request({
        url: '/user/register',
        method: 'post',
        data,
    });
}

/**
 * 用户登出
 */
export function logout() {
    return request({
        url: '/user/logout',
        method: 'post',
    });
}