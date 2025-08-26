/**
 * post controller
 */

import { factories } from '@strapi/strapi'

export default factories.createCoreController('api::post.post', ({ strapi }) => ({
  // Кастомные методы дополняют стандартные
  async like(ctx) {
    const { id } = ctx.params;

    try {
      // Читаем текущее значение лайков
      const post = await strapi.db.query('api::post.post').findOne({
        where: { documentId: id },
        select: ['likes'],
      });      

      if (!post) {
        return ctx.notFound('Post not foundввв');
      }

      // Обновляем лайки
      const updatedPost = await strapi.db.query('api::post.post').update({
        where: { documentId: id },
        data: { likes: (post.likes || 0) + 1 },
      });

      return { likes: updatedPost.likes };
    } catch (error) {
      return ctx.badRequest('Like failed', {
        postId: id,
        errorMessage: error.message,
      });
    }
  },

  async unlike(ctx) {
    try {
      const { id } = ctx.params;
      
      const post = await strapi.service('api::post.post').findOne(id, {
        fields: ['likes']
      });

      if (!post) {
        return ctx.notFound('Post not found');
      }

      const updatedPost = await strapi.service('api::post.post').update(id, {
        data: {
          likes: Math.max(0, (post.likes || 0) - 1)
        },
        fields: ['likes']
      });

      return { likes: updatedPost.likes };
    } catch (error) {
      ctx.badRequest('Unlike failed', { error });
    }
  }
}));