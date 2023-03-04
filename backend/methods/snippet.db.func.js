const SnippetModel = require('../models/snippet.model')

class SnippetService {
  static async createSnippet(userId, fileName, fileType, snippet, description) {
    try {
      const createSnippet = new SnippetModel({
        userId,
        fileName,
        fileType,
        snippet,
        description,
      })
      return await createSnippet.save()
    } catch (error) {
      throw new Error(`Failed to save code snippet: ${error.message}`)
    }
  }

  static async getSnippets(userId) {
    const snippetData = await SnippetModel.find({ userId })
    return snippetData
  }
}

module.exports = snippetDbFunc = {
  createNewSnippet: async (req, res, next) => {
    try {
      const { userId, fileName, fileType, snippet, description } = req.body

      let codeSnippet = await SnippetService.createSnippet(
        userId,
        fileName,
        fileType,
        snippet,
        description
      )

      res.json({ status: true, success: codeSnippet })
    } catch (error) {
      next(error)
    }
  },

  getUserSnippets: async (req, res, next) => {
    try {
      const { userId } = req.query

      let snippets = await SnippetService.getSnippets(userId)

      res.json({ status: true, success: snippets })
    } catch (error) {
      next(error)
    }
  },
}
