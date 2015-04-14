//
//  BoolExtension.swift
//  pangea
//
//  Created by Jesse Rittner on 4/14/15.
//  Copyright (c) 2015 Will Richardson. All rights reserved.
//

extension Bool
{
    /**
     * Returns true if all the predicates would return true.
     * If no predicates are provided, trivially returns true.
     *
     * :param: predicates the list of predicates to combine
     *
     * :returns: a new predicate that returns true if all the input predicates would return true
     */
    static func all<T>(predicates: T -> Bool...) -> T -> Bool
    {
        return {
            (t: T) in
            for predicate in predicates
            {
                if !predicate(t)
                {
                    return false
                }
            }
            return true
        }
    }
    
    /**
     * Returns true if any of the predicates would return true.
     * If no predicates are provided, trivially returns false.
     *
     * :param: predicates the list of predicates to combine
     *
     * :returns: a new predicate that returns true if any of the input predicates would return true
     */
    static func any<T>(predicates: T -> Bool...) -> T -> Bool
    {
        return {
            (t: T) in
            for predicate in predicates
            {
                if predicate(t)
                {
                    return true
                }
            }
            return false
        }
    }
}