/**
 * post controller
 */

import { factories } from '@strapi/strapi'

export default factories.createCoreController('api::post.post', ({ strapi }) => ({
  // Кастомные методы дополняют стандартные
  async like(ctx) {
    const { id } = ctx.params;

    try {
   
      // Атомарный инкремент через knex
      const result = await strapi.db.connection('posts')
        .where({ document_id: id })
        .increment('likes', 1)
        .returning('likes');

      // В Postgres result = [{ likes: newValue }]
      const likes = Array.isArray(result) ? result[0].likes : null;

      return {        
        likes: likes
       };
    } catch (error) {
      return ctx.badRequest('Like failed', {
        postId: id,
        errorMessage: error.message,
      });
    }
  },

  async unlike(ctx) {
    const { id } = ctx.params;

    try {
   
      // Атомарный инкремент через knex
      const result = await strapi.db.connection('posts')
        .where({ document_id: id })
        .decrement('likes', 1)
        .returning('likes');

      // В Postgres result = [{ likes: newValue }]
      const likes = Array.isArray(result) ? result[0].likes : null;

      return { likes: likes };
    } catch (error) {
      return ctx.badRequest('Like failed', {
        postId: id,
        errorMessage: error.message,
      });
    }
  }
}));