/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   string_manip.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: yel-hadr < yel-hadr@student.1337.ma>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/11/29 18:55:35 by bbouagou          #+#    #+#             */
/*   Updated: 2023/12/01 22:08:15 by yel-hadr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../../inc/parser.h"

bool	string_is_whitespace(char *string)
{
	int32_t	idx;

	idx = 0;
	while (string[idx] == ' ' || string[idx] == '\t' || string[idx] == '\v'
		|| string[idx] == '\r' || string[idx] == '\f')
		idx++;
	if (string[idx])
		return (false);
	return (true);
}
