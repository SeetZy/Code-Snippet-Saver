const SnippetModel = require('../models/snippet.model')

class SnippetService {
  static async createSnippet(userId, fileName, fileType, snippet) {
    try {
      const createSnippet = new SnippetModel({
        userId,
        fileName,
        fileType,
        snippet,
      })
      return await createSnippet.save()
    } catch (error) {
      throw new Error(`Failed to save code snippet: ${error.message}`)
    }
  }
}

module.exports = snippetDbFunc = {
  createNewSnippet: async (req, res, next) => {
    try {
      const { userId, fileName, fileType, snippet } = req.body

      let codeSnippet = await SnippetService.createSnippet(
        userId,
        fileName,
        fileType,
        snippet
      )

      res.json({ status: true, success: codeSnippet })
    } catch (error) {
      next(error)
    }
  },
}
