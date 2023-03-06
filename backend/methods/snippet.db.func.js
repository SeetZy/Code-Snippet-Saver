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

  static async updateSnippet(id, snippet, description) {
    const updatedSnippetData = await SnippetModel.findByIdAndUpdate(
      { _id: id },
      { snippet, description },
      { new: true }
    )
    return updatedSnippetData
  }

  static async deleteSnippets(id) {
    const deletedSnippetData = await SnippetModel.findOneAndDelete({ _id: id })
    return deletedSnippetData
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

  updateUserSnippets: async (req, res, next) => {
    try {
      const { id } = req.params
      const { snippet, description } = req.body

      let updatedData = await SnippetService.updateSnippet(
        id,
        snippet,
        description
      )

      res.json({ status: true, success: updatedData })
    } catch (error) {
      next(error)
    }
  },

  deleteUserSnippets: async (req, res, next) => {
    try {
      const { id } = req.body

      let deletedData = await SnippetService.deleteSnippets(id)

      res.json({ status: true, success: deletedData })
    } catch (error) {
      next(error)
    }
  },
}
