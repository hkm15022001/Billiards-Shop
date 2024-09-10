import React from 'react';
import { Box, Container } from '@material-ui/core';
import { experimentalStyled as styled } from '@material-ui/core/styles';

const BannerWrapper = styled(Container)(({ theme }) => ({
  display: 'flex',
  justifyContent: 'center',
  alignItems: 'center',
  padding: theme.spacing(4, 0),
  [theme.breakpoints.down('sm')]: {
    padding: theme.spacing(2, 0),
  },
}));

const BannerContainer = styled(Box)(({ theme }) => ({
  position: 'relative',
  height: '448px',
  width: '100%',
  maxWidth: '1280px',
  marginBottom: theme.spacing(4),
  overflow: 'hidden',
  borderRadius: theme.shape.borderRadius * 2,
  border: `1px solid ${theme.palette.divider}`,
  boxShadow: theme.shadows[5],
  '&::before': {
    content: '""',
    position: 'absolute',
    top: 0,
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'rgba(0, 0, 0, 0.3)',
    zIndex: 1,
    transition: 'background-color 0.3s ease',
  },
  '&:hover::before': {
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
  },
  '&::after': {
    content: '""',
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    height: '30%',
    background: 'linear-gradient(to top, rgba(0,0,0,0.7) 0%, rgba(0,0,0,0) 100%)',
    zIndex: 2,
  },
  // Responsive styles
  [theme.breakpoints.down('sm')]: {
    height: '300px',
    marginBottom: theme.spacing(2),
    borderRadius: theme.shape.borderRadius,
  },
}));

const BannerImage = styled('img')(({ theme }) => ({
  width: '100%',
  height: '100%',
  objectFit: 'cover',
  objectPosition: 'center center',
  transition: 'transform 0.5s ease',
  '&:hover': {
    transform: 'scale(1.05)',
  },
}));

const ShineEffect = styled(Box)(({ theme }) => ({
  position: 'absolute',
  top: 0,
  left: 0,
  right: 0,
  bottom: 0,
  background: 'linear-gradient(45deg, rgba(255,255,255,0) 0%, rgba(255,255,255,0.2) 50%, rgba(255,255,255,0) 100%)',
  backgroundSize: '200% 200%',
  animation: '$shine 5s infinite linear',
  zIndex: 3,
  '@keyframes shine': {
    '0%': { backgroundPosition: '-200% 0' },
    '100%': { backgroundPosition: '200% 0' },
  },
  // Responsive styles
  [theme.breakpoints.down('sm')]: {
    display: 'none', // Hide shine effect on mobile for better performance
  },
}));

const Banner = ({ imageUrl }) => (
  <BannerWrapper maxWidth={false}>
    <BannerContainer>
      <BannerImage src={imageUrl || "/static/mock-images/covers/banner.jfif"} alt="Banner" />
      <ShineEffect />
    </BannerContainer>
  </BannerWrapper>
);

export default Banner;