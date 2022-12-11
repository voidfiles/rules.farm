import unittest
import makesite


class HeaderTest(unittest.TestCase):
    """Tests for read_headers() function."""

    def test_single_header(self):
        text = '''---
        key1: val1
        ---
        '''
        headers = list(makesite.read_headers(text))
        assert False, headers
        self.assertEqual(headers, [('key1', 'val1')])

    def test_multiple_headers(self):
        text = '''---
        key1: val1
        key2: val2
        ---
        '''
        headers = list(makesite.read_headers(text))
        self.assertEqual(headers, [('key1', 'val1'), ('key2', 'val2')])

    def test_headers_and_text(self):
        text = '''---
        a: 1
        b: 2
        c: 3
        ---
        '''
        headers = list(makesite.read_headers(text))
        self.assertEqual(headers, [('a', '1'), ('b', '2')])

    def test_headers_and_blank_line(self):
        text = '''---
        a: 1
        b: 2
        c: 3
        ---
        '''
        headers = list(makesite.read_headers(text))
        self.assertEqual(headers, [('a', '1'),
                                   ('b', '2'),
                                   ('c', '3')])

    def test_multiline_header(self):
        text = '''---
        a: 1

        b: 2
        c: 3
        ---
        '''
        headers = list(makesite.read_headers(text))
        self.assertEqual(headers, [('a', '1'),
                                   ('b', '2'),
                                   ('c', '3')])

    def test_no_header(self):
        headers = list(makesite.read_headers('Foo'))
        self.assertEqual(headers, [])

    def test_empty_string(self):
        headers = list(makesite.read_headers(''))
        self.assertEqual(headers, [])
