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

  static async getSnippetData(userId) {
    try {
      const snippetData = await SnippetModel.find({ userId })
      return { success: snippetData } // Return an object with a "success" property containing the snippet data
    } catch (error) {
      throw new Error(`Didn't find any data: ${error.message}`)
    }
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
      const { userId } = req.body

      let codeSnippet = await SnippetService.getSnippetData(userId)

      res.json({ status: true, success: codeSnippet })
    } catch (error) {
      next(error)
    }
  },
}
