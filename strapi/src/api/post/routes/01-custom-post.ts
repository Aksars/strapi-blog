// Роуты на лайки и дизлайки
export default {
    routes: [
        {
            method: 'POST',
            path: '/posts/:id/like',
            handler: 'post.like',
            config: {
                policies: [],
                middlewares: [],
                auth: false,
            },
        },
        {
            method: 'POST',
            path: '/posts/:id/unlike',
            handler: 'post.unlike',
            config: {
                policies: [],
                middlewares: [],
                auth: false,
            },
        }
    ]
}